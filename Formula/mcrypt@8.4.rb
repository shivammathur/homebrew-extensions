# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT84 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "9219969c506cc6f35f980296884c3ffe477cae24f91cdafa0be4cd6826787c98"
    sha256 cellar: :any,                 arm64_monterey: "6e83ae4f760a69e20207665f358414f667aaee1473eaf62a5f6ad601153591d3"
    sha256 cellar: :any,                 arm64_big_sur:  "dd55f311d22c735c6b7c9ee51bbcb6497b1abc39901b6945cbc68890591b1c12"
    sha256 cellar: :any,                 ventura:        "b64d950a12158c993e18429c6ea5cded271e0204889c3b1332bd09920528743d"
    sha256 cellar: :any,                 monterey:       "030a308dc0eb4cdda9ca1c4875da443e42b861d87c56038101a464fffa5da0aa"
    sha256 cellar: :any,                 big_sur:        "33429ef729c0949e90e2e14c92fec69325b28cfea598bc95fdd93d3dcab4477b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "218fcf4aaa691d7448fd85272efefe1795c995844b11fca36b88a64e3f375cd9"
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
