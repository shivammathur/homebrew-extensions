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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "ab5dbf69ef04376bc4b6ab148ec1a055c996d3eee03ac788a9b2e4a79737f18d"
    sha256 cellar: :any,                 arm64_sonoma:   "0bd0ccbef564d12ac3c28a77d46846161c70142903a91fc1b1e25d3e9b12d4f9"
    sha256 cellar: :any,                 arm64_ventura:  "ed7249c39372590fe8bfcb1e39bb0ad70c2e94dee4225d64a3573cdd5415729b"
    sha256 cellar: :any,                 arm64_monterey: "6b7036d0de2ec14902408dfe254340296a75675761b62c6e3505e029bd5a5796"
    sha256 cellar: :any,                 ventura:        "5c08f312166709d7044f7e06aa34a30054d093e6b75bb5c8716023462df9bf9d"
    sha256 cellar: :any,                 monterey:       "dcda787a3306687c377a7a4109c6cd4a85f0bf48d8aab9d3f0ec93fd7ed2612e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a3a83b2eee52a497338341c96c8d91512cfbd08eca93950863a23ac6e3b374a"
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

    Dir.chdir "mcrypt-#{version}"
    inreplace "mcrypt.c", "ext/standard/php_rand.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
