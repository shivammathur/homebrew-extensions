# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5c2bb2fdf8c4b95523ed2b5ffbdf565fa73ede4e.tar.gz"
  version "7.1.33"
  sha256 "819e7b0fcb1ffc143656a0872f3a7668e4472170fa91495f6aaae549dda5fa07"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sonoma:   "6650e087829adb1f081e6a5c44d6253cc77a256d7e962c03b58e44a44bdd1a8d"
    sha256 cellar: :any,                 arm64_ventura:  "b2006a904eef93cee94118cadfb5a7d4d057929feb4dd380a153bad36d00947d"
    sha256 cellar: :any,                 arm64_monterey: "fd2b66de0744eb0381485a7da98b8858715c7d85c5187cf08e618e3c923bb567"
    sha256 cellar: :any,                 ventura:        "e79df95bfa860aae339a14f89e3109e6d144e0167b79c7e6c795203b7d861d65"
    sha256 cellar: :any,                 monterey:       "ace9422bc33294ccac26bc381119175b42c9f36d91dbba15b5eb4973da6f8807"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa2c8059a331af6f8a4d69a12fc43e65f1e90cd426649ff5dca2cd1920920000"
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
