# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/67a075e9b509891ae7b95e8ff48e73c16f63a19d.tar.gz"
  version "7.0.33"
  sha256 "29b56e2126d94f5f8fa848194fb4073f33c30ce1f484c94dd52f77de668fe850"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any, arm64_golden_gate: "91b8222e4497f40244648d2286e77a55b7158631741ce77fa41765a0993aa7ea"
    sha256 cellar: :any, arm64_tahoe:       "36401f597a6e9b95752d66af492db1e717cde8f869ce995dfdcfe97e48643536"
    sha256 cellar: :any, arm64_sequoia:     "f6e04fa19e0bd5d98677228eb05bcd98a87fa2799b8d07e764eb0d1bfc519600"
    sha256 cellar: :any, arm64_linux:       "f1bfecc60820918dcda2103a15a395fa044df1c3aff6dc177ae4153c931c631e"
    sha256 cellar: :any, x86_64_linux:      "c91f27afce088a904c24fc05d84466a60e0b04d880f0f6fe473971387b46cc3c"
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
