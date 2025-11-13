# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6cfe49e294414185452ec89bad39b1bd42cc72c9.tar.gz"
  version "5.6.40"
  sha256 "c7aea2d4742a6daadfa333dce1e6707bd648b2ed54e36238674db026e27d43cf"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_tahoe:   "0d6420fd92f09c7178b7347a40f0c4e6f2103b467924d49aa986477c041cbc01"
    sha256 cellar: :any,                 arm64_sequoia: "92d1214c974b4f29d933ce16aa08427c7aaccb823a0b0cc6ac0bd42320e46d16"
    sha256 cellar: :any,                 arm64_sonoma:  "57d5606a66f003996b851ce94af0f0fc9ee218c7234174066478a115782f1876"
    sha256 cellar: :any,                 sonoma:        "26f84db2d15dd8afb2ff076add59ae8013f6139d7322ad725760fe2b5f29afd5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3da168fcdc79829aaadc35fc4f529f0b026e042396ce4867536b5bc683c19fc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b952a25b9009b8f831d581d78644e29a41c10c0e1bc94d5eb72dba3ac24c4935"
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
