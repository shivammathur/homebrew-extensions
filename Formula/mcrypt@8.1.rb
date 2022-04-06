# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT81 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.4.tgz"
  sha256 "98153e78958d7a48dcd0dcfe1fc3c16ec987121a0cb2d7c273d280ee7e4ea00d"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "aeb5a61027b6fed2a723065c72a20421fb2c8fbe337dfe9de0895ae461166d95"
    sha256 cellar: :any,                 arm64_big_sur:  "6b39cd0e2892780df8874f1f2f7a79bba3327bb1378fe30a11ec599e6957c1bd"
    sha256 cellar: :any,                 monterey:       "19fa23e1b8d39cf4a193027b1554ae9bc8d74dbcc60fab6943877e99af51a1aa"
    sha256 cellar: :any,                 big_sur:        "a58564dd9254eb2eb2bae3a3e6c20393b7ef3d89f5d1f073fecc5fc20f9a4618"
    sha256 cellar: :any,                 catalina:       "d3c5276d0b633f45d42eca49531fab3c26d04a752ba1a3159b3aa312b85023c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9bc326129c81bde28d053932b40057623867afc4206b363431a11c9c407369c0"
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

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
