# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2a704708f1916fe5ebcafb6d91cc438341762a3205644a6a87af48fdfa28a09e"
    sha256 cellar: :any_skip_relocation, big_sur:       "068bf9b7ae0d51672622fc7755c5145267c13ca87fb3a987fec73a9be8174c9f"
    sha256 cellar: :any_skip_relocation, catalina:      "ed5abdf95fd16939dc506b53e1f5736570addbf9d540e0448ec308a3a259082a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab457f8d2cb6f963cdef25ab3b1dabf36c3930191f504a15dfb990233c09c27f"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
