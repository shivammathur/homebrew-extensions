# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT83 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "6238be33d9c24ec0f15ff23a4e2b405b7ec95d8eec7bea463b9bb7c543780ee8"
    sha256 cellar: :any,                 arm64_monterey: "da0e74eca2234d633decb97bb5601a4c3ccf0c3d0c9edd9cc34fe82918561928"
    sha256 cellar: :any,                 arm64_big_sur:  "572b3cd3be621a07ab254c406981ef34373970fcb67d358052be040f8f26ee77"
    sha256 cellar: :any,                 ventura:        "5e3b5e582f9d795fb3811e33f025cdb10b22fe0d9b9586577a0bbd0a8708d7b0"
    sha256 cellar: :any,                 monterey:       "fb4eb03c2d5331a949ccacef7f15ac0c1d0f090c904a9fcaca86f0b2fe6b8f94"
    sha256 cellar: :any,                 big_sur:        "ba87c5e3e95cf3354b54e571dc91d2adf22876cf4d07f5371e724c6803209b7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c77e2f7957af371f7704875fbbf4c6f3cae61735bced95e6fcbc9b3209637089"
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
