# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19db02dfc0c93c3dcddf34df282ee6db125203df.tar.gz"
  version "7.1.33"
  sha256 "053573e6077d61663bb95d2130b661efa52c5b10f9379243fcbdac9ce01b1e99"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 28
    manifest_sha256 "550d99d24a9c92b6a1858d6e82a5059be78d09191465ebd117aa54b34d750a99"
    sha256 cellar: :any, arm64_golden_gate: "eac0d517f03680ca92d380f799ba7a77bf56b9eb637b4182d657a2478ab4000b"
    sha256 cellar: :any, arm64_tahoe:       "b4da8801406e198ea8a40ba7da994072be8a412bd3702791fd0bcd51c49c18d3"
    sha256 cellar: :any, arm64_sequoia:     "b2f91821da83fa99775c7bf7dbe4c84bf2c0f51e21e18df83db79148c1894aa2"
    sha256 cellar: :any, arm64_linux:       "d8faac0f613aeccec108cc955ddc5e494f212ef09d05c4284884df7a3546ca49"
    sha256 cellar: :any, x86_64_linux:      "20301172f076f5bd1234708ebc18d04e6b933f40d60770fbec692692de88476c"
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
      automake_version = Formula["automake"].version.major_minor
      %w[config.guess config.sub].each do |fn|
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{automake_version}/#{fn}", fn
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
