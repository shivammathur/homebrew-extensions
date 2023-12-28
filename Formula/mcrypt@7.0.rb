# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/95ef8ca4f13d22de7f23b272c079365069aeae63.tar.gz"
  version "7.0.33"
  sha256 "412db3946a1c2813d46a68d5cd2a6d3a78dca93c0f06fcbe598778159f1e67c1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_ventura:  "e09b709ae375788751f54e8039e6e3d6f0e70c84dfd4088652c033fa840f65ee"
    sha256 cellar: :any,                 arm64_monterey: "643fbf4d76788947e3a11b79bb31f276d27fd1d4c455186f992dc81153c5e102"
    sha256 cellar: :any,                 arm64_big_sur:  "309377dfd90e43fed9aa5f0871a7759f19c89949c9016376286040873f819e9d"
    sha256 cellar: :any,                 ventura:        "986fbb55be049cbbf4eb29760103ad227c1a223e64860b0957afc63ab6731b36"
    sha256 cellar: :any,                 monterey:       "3d1e0f0893ae5c9e5e663c0c4cd629dc6b168b9bfb4f052200679f379fffff74"
    sha256 cellar: :any,                 big_sur:        "de73cd8d6fc5dc3cb7afa745286941351a4da1f328f41fbda72b3173f2c66d1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31df43eaa16c066ed921cbeb4520928cb8f876ad300d2022ee6787ff0430b0d4"
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
