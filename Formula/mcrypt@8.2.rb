# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT82 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "295963dece91e8f2742f6bcb025655488f85b3e5666d079d0c818d4239594d48"
    sha256 cellar: :any,                 arm64_monterey: "5f471822375d53b35c80002a154a4ee60cde444bf26bcee4f0873d72b1392f5d"
    sha256 cellar: :any,                 arm64_big_sur:  "afcd97ff5368226f4fb4249c22ba892080753a9679e62cdc8512e0054e39616e"
    sha256 cellar: :any,                 ventura:        "672fb436c802c36471264df349b5d4dff6a8a32cbfc630fe0868e05e8ecb17d0"
    sha256 cellar: :any,                 monterey:       "c582019e9b432f395e853a8923390ff7dd7d394b080d8c8ceb08200a11fcea71"
    sha256 cellar: :any,                 big_sur:        "084eb96247fc6acf05a0f75ae778e0309cdc97c07d037c4cfa0edf75947eacb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf33aa509fc69941f2b58beed936acf327a01ac021a126336a7b81f52b454856"
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
