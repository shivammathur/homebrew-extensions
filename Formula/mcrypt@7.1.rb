# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c9b656d85cab6bd2f0a200276cd59f4142a48472.tar.gz"
  version "7.1.33"
  sha256 "900098dc8cc12caf1e33cf1174ec8d4abb566db95145c4948cb7a61fe3c831ef"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sonoma:   "12f0d0aa974887b34dfdbf11a024d27dcf4735279a4829d9114437466f3231a7"
    sha256 cellar: :any,                 arm64_ventura:  "e05d47b907ab86d2ba7921c744ebccf0b637a81a09ebdf33addbb87694442de5"
    sha256 cellar: :any,                 arm64_monterey: "bdf339b39307a14180d5c91a9eed810650a947931d862b608d9ce894a83dfb7c"
    sha256 cellar: :any,                 ventura:        "4162961ebc8c31a49980c107310f6264ce72ee76f6f39cc190458c14664aeb17"
    sha256 cellar: :any,                 monterey:       "3deed2e655201691875e5c4275dc69d14e5b97063e81b0f82518883940f0e0cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0fedc9d1a4e93705d546b81d9243651868a802580615129d3a91f7a7b463643b"
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
