# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8e9bde45d8f4cfcf72f5a730f4fccf907eb5c35b.tar.gz"
  version "5.6.40"
  sha256 "e6dc16ae13225a59b718ffd44481f67d2df8bdef2af625f19229a1c08cf52303"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sequoia: "fdfe2d463fc76aca2467120aebc947a5b4bd0bc01c2dee74a2a0c82d2bc8f9df"
    sha256 cellar: :any,                 arm64_sonoma:  "d3887d885b6163abbe10953594c306488d62a78361004688694468b9859f0ab3"
    sha256 cellar: :any,                 arm64_ventura: "87818652c26bd217401f4cd09798ecc64db840c0ca08128e9e26c2bca4c3b062"
    sha256 cellar: :any,                 ventura:       "93bc4c78ca477b7849a3e75e005f1e41c67ee74556027a96bb679bae42137c73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8424a1be1695353b349a450238d0ef0ee64761ef12375d41607387f7d90da6b3"
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
