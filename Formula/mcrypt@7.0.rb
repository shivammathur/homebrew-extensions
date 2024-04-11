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
    rebuild 13
    sha256 cellar: :any,                 arm64_sonoma:   "437498b3dd55d5fd276bf415aa0dd412d32a50b1cd02a38f7853b2ef9c4fd044"
    sha256 cellar: :any,                 arm64_ventura:  "a477b027ba7e4bdbf0bdd8211535df768513a4291f6e014ca99cb0fa16412fdb"
    sha256 cellar: :any,                 arm64_monterey: "cd6cceff6c1572150f6392221a529ed71ec6bf1caf9420947ba1babdee2454f0"
    sha256 cellar: :any,                 ventura:        "81d4a9c248bea6faaab5e63b23614ccb3eb43c3943b3f147f34cfd73a21c9d41"
    sha256 cellar: :any,                 monterey:       "56a3debe34995095b57ce0356c76c669eec2011fe3ef958fca281a8a7962c437"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "35848325baf022beb68807bec049cbe8a25eaa98ba70163e39ef1196e724249d"
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
