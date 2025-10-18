# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2caa81b25793a7c1878530ed80a289b070cfa44f.tar.gz"
  version "5.6.40"
  sha256 "b3397170680a3fe9f1ba36298794af232f76c1eb6d647cd0fe5581a5f233ffc3"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sequoia: "dee6272d3c6b84f6e4647bd7b51aa44a4500526066e715955499a7f2b0445925"
    sha256 cellar: :any,                 arm64_sonoma:  "48863afa1224e9235d5615d259a28aa32ad5a9a8637775187bf4d9b48b5fa6a2"
    sha256 cellar: :any,                 arm64_ventura: "9f22a1cfa24c77ca668fc709e692817025b536ac547e9e84007c62929b27b6ee"
    sha256 cellar: :any,                 ventura:       "6ba603cd75f4e4bb72326093adc45fcff0b18558acc251430545cf76e2c2f1ba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5de5e8fec594ae7fb7b21a0cb4d3622037c93f807d8dc4f455f1b0a33db8828e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a336b2e4431d372e58a08d14daef7bf37a393247b7160f3b5926055cf772e41"
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
