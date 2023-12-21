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
    sha256 cellar: :any,                 arm64_ventura:  "38a36f53a9ee56a1a6ebdf20635471c9200e207defdef6a07692f13535a487cb"
    sha256 cellar: :any,                 arm64_monterey: "97dec188e866f847e1329e84315715e58f71ae4383c6c58ecacd095c1f050766"
    sha256 cellar: :any,                 arm64_big_sur:  "e1c54030fd17d1b7e50e4e9f5e626f11a07ba52c6b3207ffde4600db0e7c3664"
    sha256 cellar: :any,                 ventura:        "fd121d6b40969198f32939607ad6a1e903e9ed121c3baef3f69ec72ca447beee"
    sha256 cellar: :any,                 monterey:       "aa7cd22886ef0b47117f40ca27024f617a77bc067b98e7e236545d4b073f939d"
    sha256 cellar: :any,                 big_sur:        "8152db6ea3923d74f41068db6f3f7fe9957fa176df51ffa4c91eee37dac337ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8823eb834be90caa56863d68293258b5961e00d5cb8f92a12b5d750dd17d383"
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
