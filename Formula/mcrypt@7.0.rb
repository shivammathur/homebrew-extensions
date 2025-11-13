# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4de530c8e7f4d5fa3df1d0e15d79a7bd44cc597c.tar.gz"
  version "7.0.33"
  sha256 "3371c5712eae64aa28eda7733a02d93ec298894d57eb0ce3fdac0904bbee4a16"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_tahoe:   "a44a22d3766ed247ec7f384646405675e5c24bbb035e8551c04d1668f4798f09"
    sha256 cellar: :any,                 arm64_sequoia: "2e6e1084106196fa0161ef6a738996b21a17d0743fe383a19c1f7df51f0de72a"
    sha256 cellar: :any,                 arm64_sonoma:  "48b5b0c76cb8204df832ced1f12b0ea97d8f99dcff4061374822c327a3e7946f"
    sha256 cellar: :any,                 sonoma:        "4f68f803f1b0b8bf4d931c8668e659ad5d03dce6acd000df787307f038cc8711"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f45d42a85e255be58c6fa6ea93c3205684aea1f777ea28770277a8444d4a3898"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f270d2b7757040c9d13a4277b0f79eb0787f46c6521f793c72557fce5c99c32b"
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
