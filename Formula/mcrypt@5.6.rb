# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e335ce1458e12062082ad9f736427b718e5efcc2.tar.gz"
  version "5.6.40"
  sha256 "0af841c702c2390d1027b619b616a0ab68b906c7314fbbe07c6cae24925faa69"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "aed698768a2990edbc5d3b8c7939e4c3edca7cec5bb44414da397c36cff90f2a"
    sha256 cellar: :any,                 arm64_big_sur:  "00d120da6fdd31449d4b93ea61c8d683cd8383b51c54536033db2e9cb79bf611"
    sha256 cellar: :any,                 ventura:        "eeb218aec02f9798a1179d7a0daeaf30442e0e61db1fd14904654e0c0e7cc619"
    sha256 cellar: :any,                 monterey:       "64e9fa1fd5d6a90ca3f1e9195c244789c76f0f125572a816febe2f0638bb48e9"
    sha256 cellar: :any,                 big_sur:        "46f89e4c9d7c66b9c4c0b87f26c1c855e647b37592f143dc4f0b62024c63d950"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "375e671e34fe533f707ccacbfd061f57cddc730e66024d3d4f60aadfdbea1acf"
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
