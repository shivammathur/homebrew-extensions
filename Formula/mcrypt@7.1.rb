# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e7c01a16aa91e459b93bb4fdb19f88764e006e58.tar.gz"
  version "7.1.33"
  sha256 "47da6ea441e2e61069a7456f5e098d91ef97ffc1f81f5817550eec5a3cb0f36f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "aa5a70025331e7ce807dd208d15e948effe6b58cd5660b44789d597a98247dac"
    sha256 cellar: :any,                 arm64_big_sur:  "872d61e03260e027c18f9f66c99ddf001c9ad8a5d165029c851c9c1c5349525f"
    sha256 cellar: :any,                 ventura:        "759ef3d0639568c8037a9d23461ade2db728219a65d156ce5e539839e463d40b"
    sha256 cellar: :any,                 monterey:       "c159596c0c039335addc4f7da204889e5d7152da1219c421b5be968b6825ab28"
    sha256 cellar: :any,                 big_sur:        "a36904601ae527e8a5acfdd1fce1532ab85aaee2a93e34fd131e51e4fe820e83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fedd62e600d853655e3fb72d7da0711cddff57c7f443d7c06cb372ff89cad48"
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
