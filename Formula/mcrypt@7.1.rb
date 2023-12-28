# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6c34dd8846d13d06f91a0d1b61bce9a941756831.tar.gz"
  version "7.1.33"
  sha256 "bd305498a5ba9e47fc60ea94fe2bb552e0833fadf04844a17bb68cc75d46eced"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_ventura:  "af74e84337d40f7b116dee3abf6ee8416f693b4a91fd6fb221f8382ca69bdcdf"
    sha256 cellar: :any,                 arm64_monterey: "7f41272ba6384478cb98417633570a3f725d83f6fbdc6ad8505fad2bec7ec09f"
    sha256 cellar: :any,                 arm64_big_sur:  "1e57e355166a230d1d48455f620cb2ba25598b270d3467ae8c5e639493446229"
    sha256 cellar: :any,                 ventura:        "c2f28cb2404c53e2c819489e3ff8ce8278212dc037670fea2a0a2680ae023622"
    sha256 cellar: :any,                 monterey:       "39bc7f84a0aecd374fe783b28196b9d98379cd29f73d89e903cbad95a28516e8"
    sha256 cellar: :any,                 big_sur:        "e10b334db4011b5c14def1e9065db61b8d8303e5f4e0c3945746c187dea15096"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0223d30dfaa260cf7f53921fd7af28249b1f40bc03fb47299b3e032e909b91cc"
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
