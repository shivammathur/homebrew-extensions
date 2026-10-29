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
    rebuild 26
    sha256 cellar: :any, arm64_golden_gate: "607c0d691c51bd771ef0de62d171393b64164753e57d9d6e15362c76ecb516f1"
    sha256 cellar: :any, arm64_tahoe:       "1ba5b1f63544b71b45316f1eea3a5a1002ca20e248f289689b64897c545d98f3"
    sha256 cellar: :any, arm64_sequoia:     "796f7ef488934e7a2a2f0fd7d118d392f4037351cdf45067a9774ceab20fd344"
    sha256 cellar: :any, arm64_linux:       "efadec2d552051d856f58ff1e1a3e8058bb437561adad017e7761ad68a1f9fba"
    sha256 cellar: :any, x86_64_linux:      "a2e904df6ed5178def0020809fc4e71250061f014a14a30720acf812be2fa39e"
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
