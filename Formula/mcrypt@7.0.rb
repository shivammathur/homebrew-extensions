# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any, arm64_tahoe:   "6fba244ded4847460cad5168973c357af1aeac953a4157ec1d2f0b3697cddc35"
    sha256 cellar: :any, arm64_sequoia: "bc5301c8bba4df91fa892e37a56a34964a9057f6de7ca9bfb81c8b877925ba57"
    sha256 cellar: :any, arm64_sonoma:  "6af39801110936bdec56973fbb5bafcc2057d46bd33a07d6c68d0d81d2b5f00b"
    sha256 cellar: :any, sonoma:        "dfbfd6b33e0a3866f364b428fa50948ca9cb2a7aab1ebc37185327319f784f48"
    sha256 cellar: :any, arm64_linux:   "a8e7b2ce552127633a913781b2500a48cb5144f496f9e056daa8c76f73d5db6a"
    sha256 cellar: :any, x86_64_linux:  "a8a2440ca8b802a9978b584d80a3ae8fff2a1ba035a6434705586b419ec03a78"
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
