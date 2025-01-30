# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "e2bddae5592440d26a7c1bf7135b7c08e9fbbe6d475302e3481883fa91e950c6"
    sha256 cellar: :any,                 arm64_sonoma:   "77c5f8c7ae3d86a368a11de25492e682234bcb6c0cefcd4a22b28d25636b3676"
    sha256 cellar: :any,                 arm64_ventura:  "1d9987f001881435900d54de0438ddf99bd9bc4e61e39354bd08535e87d22db2"
    sha256 cellar: :any,                 arm64_monterey: "fbd999ccf3ec36e5571dbea29c854946e1e4c6a5060ef704b368afb54a01b25f"
    sha256 cellar: :any,                 ventura:        "e8da6a6195aa1f723e5a5b5a5bd05a363c98c143a5484205021488ccc66249ff"
    sha256 cellar: :any,                 monterey:       "41b28dfa4b874773fc32b82d49d8002451337da2b8b4c986862a7c3474f30797"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7c164f4d33a415661dcf4001b02414c61348d08b0d3943449d1dbd6ca20911d"
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
