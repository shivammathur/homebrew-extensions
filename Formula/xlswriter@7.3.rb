# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "58b2645e2c93a7a8b318b95db29d7d4a4c9a4bc2bd9b3d7fadab9ff38a42910a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b3a13fccc57d503e78264ddd46b7783d81242fea28339f4ded170be54a8da9ae"
    sha256 cellar: :any_skip_relocation, monterey:       "50921e895d8e9c2597384fff5463e9316c5be7bb207667cb1ce946fe985e5d9d"
    sha256 cellar: :any_skip_relocation, big_sur:        "d6d9ef68013e507b1eb38a23bd476c5a6f4b32943af2bff2bf51e0b27c6e691c"
    sha256 cellar: :any_skip_relocation, catalina:       "ff98e695011b872676160e7708de315e2361c020018248c79b2103b49ca8cf00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f46cec70f2da5b2702272d6094910d2873500308ebbef6ddf7dea94c25720b6"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
