# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT81 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "aa60c3a8282170f1e03fdc9d7c08a9f8f0c9c2bc22411c0f1908062a15c51dc8"
    sha256 cellar: :any,                 arm64_monterey: "a34cfa3447a90cb46f1297dbe93a78d0d12f50a139b3cc42019e3c4cb658730b"
    sha256 cellar: :any,                 arm64_big_sur:  "eab8c723e3a602323b8f2b185bea6afe9804e168e8b5cd90b311531d6f4c9c4c"
    sha256 cellar: :any,                 ventura:        "6ce4babd71a42ca92644c6a1cd5c6421488b3c1942b1b20a6796f5f57b0588cb"
    sha256 cellar: :any,                 monterey:       "2bf556996dc64ec84d705e86494a2be3c3708904aa29a0c76f0dc70f78199072"
    sha256 cellar: :any,                 big_sur:        "cfdb5e9d9a8264d450f31e2b8450aabac4d082a2b972f8bc60b9683596c79cb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "457dd15530d2f8850189111c5e9745161df42e1b8fa50ed92b8dae9bdbdc755e"
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
