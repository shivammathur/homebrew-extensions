# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5e62c706a462f60c85f5d81a21a38717014db0f0.tar.gz"
  version "7.1.33"
  sha256 "32f62131bef57d27b047b75fa83474557541a3bbf7d2b93a3b5c5e3525b08f6a"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any, arm64_golden_gate: "431119551d7d14d4ce6310a8a832b113e811b45f79133067c03f965e8704ef15"
    sha256 cellar: :any, arm64_tahoe:       "e1741c1bfdbdbcdf99dd21906794a37f8e2ae3c4f3654e48846a103efa44e83c"
    sha256 cellar: :any, arm64_sequoia:     "3503c6d406b4f2eab2c7ff9b3011fcf278c9535f713ce8645af9aebaa7c92079"
    sha256 cellar: :any, arm64_sonoma:      "5157ae504717fcd86c1c2325e35ba07eaf772b1a60948c6a815ab9e6db60afb3"
    sha256 cellar: :any, sonoma:            "6a3a35ac4d1a7a73b68c778c5da369fd322af026ea3f64003902412271a35bfc"
    sha256 cellar: :any, arm64_linux:       "dfc23da351ff297283aabf60298d084ac9aab71f849c2016b18c788a78b7a596"
    sha256 cellar: :any, x86_64_linux:      "125d530574c175c96a8715a2c3c2ab25605523c76c43bfbcbd5df7b748cfe600"
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
