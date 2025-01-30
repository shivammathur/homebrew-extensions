# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT73 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c2809282c1df9ce0adc7d8290adbafbce937c2c7a61ea5f40b16b0192e4361cc"
    sha256 cellar: :any,                 arm64_sonoma:  "80a7362ae0c1c2f3a69a0e7d6fbd600ac8796a7e8dc149285f8800f63c18e284"
    sha256 cellar: :any,                 arm64_ventura: "daa3a968f081d6391ab9e2267853e32cd4dfef06fdd2192e6437d31baf36646f"
    sha256 cellar: :any,                 ventura:       "3d36239db774a95bb90bf6a7215e2c58d2df36b30acea926138cfda0be6bf244"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5fa08a92376895085f72759d9b6ac670fe9d5e8aecd2192a2e2c87f63b09959"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
