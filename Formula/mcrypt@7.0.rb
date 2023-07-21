# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/01620e1ea421be6f10360fefc1127e96a9c80467.tar.gz"
  version "7.0.33"
  sha256 "6f801b4bea2dc7025bb09144eb2c63493ab3013c7010d069d8464e88528d29a3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "56c87ab6cd144d80ba3b8e2387a6eda0c25fc7521491e97b3588ea5246efe166"
    sha256 cellar: :any,                 arm64_big_sur:  "0d07b1195035faeb249bf45cad76f82304fe49394f35bf1025964ff267082ae0"
    sha256 cellar: :any,                 ventura:        "626a7287948bbd211d01606855f0fc4a510e77a5a382402723833d7133934e66"
    sha256 cellar: :any,                 monterey:       "5c820698cca7b7ca5b9edfa4265a5419c75dfbdbe57a6a360e4cc3ce29205702"
    sha256 cellar: :any,                 big_sur:        "1cdcd5022f3d474c17e27b39fd292e25f34b2aaf701c7467cc0f718ffcf5061e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0a25daebdbc401fe60860d34d0b5360d2f4b0bc63a4151cabb4442d1a60a0b49"
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
