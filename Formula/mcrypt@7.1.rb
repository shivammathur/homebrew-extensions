# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/ab57e06d1e3481c1fbba19edc429e75634b6da88.tar.gz"
  version "7.1.33"
  sha256 "7ffa8f8d30b31d0632fa1ce26d32cc303607b2f88f5f86778ca366b10db05b5b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sequoia:  "a2c851d5cfe7dfd650a0c8dc8c271fb7d7a51ff2c8af3d2109a062ebb5600b12"
    sha256 cellar: :any,                 arm64_sonoma:   "ac6f9d241d1d1168f342f04688d0c4661c811b5acad17fdbca84fe82aa412434"
    sha256 cellar: :any,                 arm64_ventura:  "cf5b818f217f5bcdccce8e8423d5f1fa1698ae1bc89f2cf1fb8f919dba61053f"
    sha256 cellar: :any,                 arm64_monterey: "8bf90c5543971056fe3230cef5861936ad514aa940238f11872e804ae1e63d44"
    sha256 cellar: :any,                 ventura:        "085d0a49f5cec1472a5b6db6b2ab622b4849b325d25ad273f6f4b7120105155c"
    sha256 cellar: :any,                 monterey:       "465dba105fda9252038d261f14244934b28846a340208004d4626b01838f32ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a2701d5ab61fab727fd3710c5b3568f883ffdbe4046e342661878e4d4e47dabc"
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
