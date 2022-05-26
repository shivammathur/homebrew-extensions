# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT74 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
  sha256 "c9f51e211640a15d2a983f5d80e26660656351651d6f682d657bdf1cfa07d8a3"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "85920704fd7a0ed31dfebe40f3219c41ccc96e45289812d331e531df0498d00e"
    sha256 cellar: :any,                 arm64_big_sur:  "7ddf99e4f288a2266fba0ea1136053eca585b2474149b8f0e021d3742efc534b"
    sha256 cellar: :any,                 monterey:       "9f220bd79290c2095f07c0d02421dc30ebb34906bd1464b22a0ff2731ba8828f"
    sha256 cellar: :any,                 big_sur:        "4420e7134cb994f3c7e2396be1aa9db315b4dd3b815b24b172d14fe3a788795e"
    sha256 cellar: :any,                 catalina:       "ac2a0da7a167a0a8efd1dd3c603fc709d5f1765bf980e5e107d60256cd5e5d45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3645f7f992bea0a49498bfd3c216312cc9d8aad070468e038d56d93f28e0f32f"
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
