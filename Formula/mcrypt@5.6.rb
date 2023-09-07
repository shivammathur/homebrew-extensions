# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c348572b0d1b2caea46e664c9d3316bb4a74fae0.tar.gz"
  version "5.6.40"
  sha256 "290f56c9abc0a5dc2771078a655ee67d2ee5bdb3f14e438741584cc71887d1a3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "821a51f6406616dd6bd3671c3d97aa89c93c0f3f16e6aa15c9c11d244a865fa9"
    sha256 cellar: :any,                 arm64_big_sur:  "1ae8f3af9c98f568bda1b1535b3ba5421c76a9ed301cefdcd2eda6da7a42802d"
    sha256 cellar: :any,                 ventura:        "4c11ffa093980d0ac4f761f9b8c4a4ebfcc9ff34356c0a31448b36a7b8ef33e3"
    sha256 cellar: :any,                 monterey:       "c43940304df1f0217593ad50554f88fdaf54a9e7094a8a2d884e0940621c8774"
    sha256 cellar: :any,                 big_sur:        "93399c620676ad6c0ffb89065ca7b93b4b420898e68038257efddff37cc2ff9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "78f51796bbce1cf901e693d9fc180b2047f17ad62b096bb7784d6e39633fac41"
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
