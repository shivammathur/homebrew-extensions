# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any, arm64_golden_gate: "769840c6666e6061e3f31e90c92e5c29803d3497351c2ae25eb1df9687bd9f30"
    sha256 cellar: :any, arm64_tahoe:       "c2dc34b5a85d62a6db677d8abf296ea8c3f5980e48739494c26dbecf6c74a9d5"
    sha256 cellar: :any, arm64_sequoia:     "00d2434f34b4742bc05e656795ee9cc256358a1dea9a834d4049a8544ed42b75"
    sha256 cellar: :any, arm64_linux:       "cb998fa3324e5edaf903c53635c4499410296273e2a91ebb48a99273088b96f0"
    sha256 cellar: :any, x86_64_linux:      "f6c463d475432cd5a130771d5e29003b1db65a64187096ec2d83912767351707"
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
