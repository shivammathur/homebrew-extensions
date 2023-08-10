# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e59f61709da3d6dd00f31446beb9574a0d2331ce.tar.gz"
  version "5.6.40"
  sha256 "bc226d7bc4c4557a8305f6c1257bdd15c83c9f726f6ccee94982fdf87d005443"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "7d72ca567582fce09c6563958326597024c4faaf3ada37c0fbc96f388a9bddc1"
    sha256 cellar: :any,                 arm64_big_sur:  "1f899d012bcee8124b6ff2afb72ce5ec32c15037d2aded420cba24028f6edbc1"
    sha256 cellar: :any,                 ventura:        "bfa6870faafc5d5d453e830470cb4350526b21c5af50f800b470c884c90eebb2"
    sha256 cellar: :any,                 monterey:       "c59aace1b4909a4eccb624017c04f16520a0bf7fb7209a97309dfdfb5c4a637a"
    sha256 cellar: :any,                 big_sur:        "95f194c1cfd28408bf65b64a2acb1003f5fd97464e2dc7a60a3193e249f5b341"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e6704ef9c962a2d35fc93f30c237765ccc11be700ba83f79c9b787b577fded56"
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

    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
