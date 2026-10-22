# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/76d932fdc0b984a1a8d9bd42bd04fb386e36135f.tar.gz"
  version "7.0.33"
  sha256 "c7363edcfbae285748026db1e4dc70d119fead29f49c13fc42a0067d1b093241"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any, arm64_golden_gate: "8c5a4186b04abe44e091a03dec17e2f624a33e3778de213f5565d08ae4c194b5"
    sha256 cellar: :any, arm64_tahoe:       "3b79a64a5d5188e4eb558129de03dd8c1fdd2ee7f079aed4ef6c2ed053fe7c26"
    sha256 cellar: :any, arm64_sequoia:     "8375cee6d31ac61cab666b04d0450bf9a9b43ab30297a964258028ed1c13ad7f"
    sha256 cellar: :any, arm64_linux:       "ca6d3bd3bb5f7f1284ec9307ec7f07406fca83998541d60ae2a3b6f022fba57e"
    sha256 cellar: :any, x86_64_linux:      "9e054f70e361a4b66fb2cdde219e53db4937858bffc86e7fcceab0ce5172891d"
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
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}",
fn
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
