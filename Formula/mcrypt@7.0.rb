# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a39dc7ab765a65cc77b7a7ff2fe3dfe2cbba5c4f.tar.gz"
  version "7.0.33"
  sha256 "4f218a72364843aeceee8e7f170d20775ba2e9ae9fc0bb82a210e9bdd226705d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sequoia: "4ea0730b9b38b2cec3d9d0a9bfe3201df62966b8a02e5ecba5ca7876a4eabc98"
    sha256 cellar: :any,                 arm64_sonoma:  "0838126420b260432d5ec4e5975932e688b2397637a746c68baa8a1eca72db43"
    sha256 cellar: :any,                 arm64_ventura: "cee18b2416db97cb6b822687b4b0ced8b6d374e20179f860e20e7c2cc87a0cc6"
    sha256 cellar: :any,                 ventura:       "de9b0626b600b7ddeaef547699ffa218ebeccc5712d1ea5e5aa1211d16bf220c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "326b3413efe90a10696215de0c71544ad3e9c545cf0c598dd28d424ff944d9f9"
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
    ENV.append "CFLAGS", "-Wno-implicit-int"

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
