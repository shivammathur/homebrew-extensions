# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8c84e4ab015127711d096c461c3ec661dcd8c925.tar.gz"
  version "7.1.33"
  sha256 "4aa6a4d33f4a67fb92f64f7b264b84cd3b81993443bce3b358e1b15acd7e67e4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "141d6d0e83f3e0e20aec9cf8c9e8358e189a2e9248a1ad567e59cc1e237e1d29"
    sha256 cellar: :any,                 arm64_big_sur:  "9ee3e2f9cd8ac481569fc916ad207890a5f0f34e18b868997003d23308cabdfb"
    sha256 cellar: :any,                 monterey:       "195dd648b8cfce14661a715c33747da0ce29d473915e8f94318b468a12dca52c"
    sha256 cellar: :any,                 big_sur:        "d6b56737e6df80edd77c5245310447577eefc1470b1f553c552fc17f8ea59c8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73776f815bdbb8857c38e5c427d8a0bada93d9affea5788398784e5c00ac24b6"
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
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
