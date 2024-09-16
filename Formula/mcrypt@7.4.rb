# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT74 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "f6217543ad5453c1ae753869f056b5295e877ee7574fd65dd3b5d4645d704aa3"
    sha256 cellar: :any,                 arm64_sonoma:   "950a34bf44f9055fcac4a6565a00272c9e4cd810d81889e201123d41661c5f0c"
    sha256 cellar: :any,                 arm64_ventura:  "29c3a81e8bf59f85e8d3d46e0488b21440c78653f3a8b15ad07529eb6e8f356b"
    sha256 cellar: :any,                 arm64_monterey: "f74aa31d185e0bdd1ec379a4da3f993a1c1b474e1bda6ad0b415a3ff4d7f79fe"
    sha256 cellar: :any,                 ventura:        "f52ff6b191ddd1cc1a933763884f9ef28741692de7f5ee3a255860c7b93993e8"
    sha256 cellar: :any,                 monterey:       "ac112df82662e1bb6e82b7c5d58293ccaa9db8be93168063f35eb722746f77aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61d5d24f29276ec373ee4e3ea3d4f99a17035aa3d229e6085986cf7102a871b9"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
