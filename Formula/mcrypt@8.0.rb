# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT80 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "ce5f60d44dab2996d91ec504c1f435fd80c2c1175c5a12a58793f2d5dbeaeb7d"
    sha256 cellar: :any,                 arm64_monterey: "3374ae0461253a80f755af889595ec9c408afb4813d6c5c9a6e4d2548b894613"
    sha256 cellar: :any,                 arm64_big_sur:  "d9dd9e13a49e6905827f75b026a6791046f3f84d5cc3137862817471e159ef5c"
    sha256 cellar: :any,                 ventura:        "1f65fc6c09814e89d3ab138ff8f5cfba6c0f651569c010d63b42c6b927a914ef"
    sha256 cellar: :any,                 monterey:       "0f11cc21553bd6834f28028632a9ae1bdef52ed4c0b09a7e09758b30cf1969f0"
    sha256 cellar: :any,                 big_sur:        "fa8ad6478defd4fef23f020821205a6701f64d59b32284385d79376c0b2d9049"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "acd80cad43af5a7ca17a001b0ba5633342cf71bb39bc4a0d71125852727210c2"
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
