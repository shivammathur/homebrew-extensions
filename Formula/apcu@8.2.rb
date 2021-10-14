# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d8bcd5e92468465664e29a24ddba6cb25d0c9a7a864bd58e06299e5fb88408a0"
    sha256 cellar: :any_skip_relocation, big_sur:       "de6e4e4fe03f5bc531d57e4dcc552df3a2d29ee3c2c1b335540a3a3cd7eb9357"
    sha256 cellar: :any_skip_relocation, catalina:      "c4ddeacd9727973933ca81c0511ee35f14490c2ec027a28e643953908c2608ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e3a755fa00d9198491e8887c3b42495c52a4ac55f201f6d630f94663b9668039"
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
