# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT73 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "fa7a7e13cd0a98d8fc31a9d14935bd78cee86f564011e096b3e35956539f6ece"
    sha256 cellar: :any,                 arm64_monterey: "d48b78011917eb8b2513fae1fd8e3c76ac779252d890d2a5973ec3f8cf060ba7"
    sha256 cellar: :any,                 arm64_big_sur:  "d913742eb4b669c59d730a59cd1a41290c5298c346a6a39157b64c6507dc2a9e"
    sha256 cellar: :any,                 ventura:        "d49299b668c328aad688002c3bd9e572beeb2b72810d25843e805b39aba74f70"
    sha256 cellar: :any,                 monterey:       "138333cd73a892e858c4327f39436aaa6d53f70303aaa951bc3d5f75659117db"
    sha256 cellar: :any,                 big_sur:        "c8043b105c0956d435e5d8b3403fa7b408960e6b10395d159f3aa1286673b1e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d09282c887ea3aa6eddc822fb10e7509995b205e4f4cded4379a9e300a1ad094"
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

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
