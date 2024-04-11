# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91d880e29357a238394a912121bc48a6225bd7b.tar.gz"
  version "7.1.33"
  sha256 "cdf3ec0af871a5930a9248d8ae28a444262d64a4674e7d8ab9b714eab82f48fb"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sonoma:   "49c6bc4eb86c839f9028867cf7734b8955f7ee9e6b91850a4321a8b533fa0dcf"
    sha256 cellar: :any,                 arm64_ventura:  "f7b6feaeb021e04329507833304b10878dfe886722e0a0e3da7f864adeb4f3ef"
    sha256 cellar: :any,                 arm64_monterey: "4b77adcd66a92103cfba3d9513e345ace6e08c97ade6e84f6d7bef53d50074a8"
    sha256 cellar: :any,                 ventura:        "11f85811a2999586f88e8d29545c2009eec1e3b228ac9229686286fa2e7be77a"
    sha256 cellar: :any,                 monterey:       "5e32f0c5d8ea65ac294fead4bc49e6e34a6f96eaeec625f66a362785be2db6d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd3e7219d76cb52a6512afbbd74c4040e61b4bb831606ad80a8a9ff3e889ff3f"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
    sha256 "e4eb6c074bbab168ac47b947c195ff8cef9d51a211cdd18ca9c9ef34d27a373e"
  end

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
      end

      # Avoid flat_namespace usage on macOS
      inreplace "./configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "" if OS.mac?

      system "./configure", "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    end

    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
