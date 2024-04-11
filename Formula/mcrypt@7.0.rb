# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/55d42c0821d426b22eed16e07339fed20cc130ed.tar.gz"
  version "7.0.33"
  sha256 "d8f0f03a149d5534b75c7a144ba06fcf3717a9bed1fb2541e6972534fb15e884"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sonoma:   "072c82f9a8a4a936c7d3ecb4ce26d5808fb37085c13adc4f345a7fa25bdd9120"
    sha256 cellar: :any,                 arm64_ventura:  "01e255edabcdd7a573c285f16b5bf8fc2e318bdb421d8be028425eb029020984"
    sha256 cellar: :any,                 arm64_monterey: "612cfa95ee212c3e75653db32cd4a560830a9ca4a90747f6e0a3c961f01edb33"
    sha256 cellar: :any,                 ventura:        "9aaeb3f0973df8c0362c47b9284592229cb576f7ab0185adebbff7875b2dcbcc"
    sha256 cellar: :any,                 monterey:       "10c8a268676e9cd20d9a5e2ebc14ec9eba32f207240ffd19a5bbb82c9b722e34"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b3cb0143d7857951dc99b60f1086810e8647fb50d2eec0946ad059f21dc53e5"
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
