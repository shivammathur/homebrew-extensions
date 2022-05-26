# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "68af371bc1d69a378f2f2223f036a0184a4236661c4d098ff310f3b8d25a7983"
    sha256 cellar: :any,                 arm64_big_sur:  "132ce418adbfc91d9f6d9e3a5e45386cb19067c8575ad0b174e504cb4c48880b"
    sha256 cellar: :any,                 monterey:       "5f15a39ab604dc2d4f17d0632fdcdfe957826409dc9e8d8e7a65d447b9a336aa"
    sha256 cellar: :any,                 big_sur:        "a432cf6bc0806e7b2d9dcaf02352baacbc2fca0516b33b44fbb3c968b38ea3b5"
    sha256 cellar: :any,                 catalina:       "0c5cbc0f0ff31ee06ff8371e57c9c60b57ba5332566a6f5b277fbc5e5c5109e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b5f1e159085243ced8aabaa7b995fd56754ebd1aa7ab59f65078f71d079c9e67"
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
