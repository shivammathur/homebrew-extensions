# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT72 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.4.tgz"
  sha256 "98153e78958d7a48dcd0dcfe1fc3c16ec987121a0cb2d7c273d280ee7e4ea00d"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1b5a7430358d6ccc1ca69b1170d9be9f96cd562f1a2e25111e955d3216eb39b5"
    sha256 cellar: :any,                 arm64_big_sur:  "6fe45364d792a96f820e3a151dc3b9988e1345f1034def911e057a5a11093b8f"
    sha256 cellar: :any,                 monterey:       "bc72fbb33916be88283707837def28327c1ccb23fc7ccea77e71e0125b3589e0"
    sha256 cellar: :any,                 big_sur:        "d56bd3fe975c1d5a087a9301fb77a3a16019a78ce4086b84c9ad93f12ad0de0e"
    sha256 cellar: :any,                 catalina:       "c2498ce13b61f3f4b8ac5ad7cbebdc3b2bfa64beb4b5b0390e907ddb9190640e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12b6148ab5ede76827e848c12488ff4da652926f1e1c2bf115b8b783d6ed2e47"
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
