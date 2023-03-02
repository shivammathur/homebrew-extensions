# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT72 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.6.tgz"
  sha256 "be6efd52a76ed01aabdda0ce426aed0a93db4ec06908c16a5460175c35b0d08a"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1a3c65ef034546f6fd726348b408afef138b79dca5b219f44ce24f226935d33f"
    sha256 cellar: :any,                 arm64_big_sur:  "4bb69e6f46828a4e469e77f1bb286e7a38d2f32c081f558566d7a941c349df95"
    sha256 cellar: :any,                 monterey:       "089770bec3fac96c666929f54b5d22c991f33af10196cd18c3eb6cbb1fd558cc"
    sha256 cellar: :any,                 big_sur:        "0107b9d2934ad27615cb0eacdddad47e08edc4b7ff1e7b9a34def8b98dd0ab16"
    sha256 cellar: :any,                 catalina:       "c7bfe4776147123b823d5a0dea4ad4929e08df63b35befd8dc528c5cf82cdbb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d7ebd955f2c35ea6a723f99c84b1e4037c44825bdbf141c0a81b6cac0486123"
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
