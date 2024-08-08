# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0788496bca56ea3a6ad75758aeaa38f81267415a.tar.gz"
  version "7.0.33"
  sha256 "6b59873eef34f7205e20683a0e6ad99509a1c158e619ff52ae6269d64d49f5e9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sonoma:   "c026e32582ff28526d714db6c96e2737f03def97e6967c8445c87f15d5d79c3a"
    sha256 cellar: :any,                 arm64_ventura:  "854a07e3df8424398cadc5546b18373065be7cbf99207420ad9fa29d8ce25484"
    sha256 cellar: :any,                 arm64_monterey: "a36e76742fd8bfe20c785e9efef96eeae9650c91750466904ab059e60703a0e6"
    sha256 cellar: :any,                 ventura:        "e55cef6b78765350fb28f7436db2559c6d23dc6240386aabeaac327dccb9c2dc"
    sha256 cellar: :any,                 monterey:       "038538d2161c32051ac9bb52eb5ada5d7821eb757bf2b42a1caae2c1e65ea8a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "705831251f19b8f3372fa784a025bf8fa5cbb000e6ee25db91a29300c4a01231"
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
