# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4cd450adf633ff3b756586f5ce8fb31a7c7f8359.tar.gz"
  version "7.1.33"
  sha256 "632a98f29d7e023b0dc4d3ae9680877f8f7aafed162345ca3318f5e9d1f87db7"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_tahoe:   "6a248aacd944d245efcf3e6ff7e74c6d1ed7558a2126ab6b3e0c4f40b2232b48"
    sha256 cellar: :any,                 arm64_sequoia: "443e6b82b192249ed90ce2adb77f15406a88b11d5761bdb8611dcdea8e66cfeb"
    sha256 cellar: :any,                 arm64_sonoma:  "9f2622ccfa10e65154d82ea1071abab426111842b5e08e5be2e9c2fbb7a3096b"
    sha256 cellar: :any,                 sonoma:        "2eba39eca6007267b2cb2fee14514a88851f851268887c1650254d4521089c04"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ab13247b60981d7a2cfe34e0096cf3fd6abeed749f13afe13e69007729d91ead"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1301d2db0f1c6bd1d323ab27fd6761acac2329db6a43af893785d639a60cafeb"
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
