# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "086be9e094e571351c0d76353a63f7dca57ae11ab6d00a4c94b1533042716375"
    sha256 cellar: :any,                 arm64_sequoia: "8bba76a063087f4c682b8f95639dea5cd5f074c8d205f20577f1677a0b431922"
    sha256 cellar: :any,                 arm64_sonoma:  "e738dc7e9be7584f31d3732b220dadb7d2cd3704fcd773851b94f5bf973e3cc7"
    sha256 cellar: :any,                 sonoma:        "4c9aff7b6affd9e0429cd284750a9096b7864141358324b1f457227277cb685c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6d76f957ee9dafaa5ba6e1abaeea54ab17ef11a677b9ad3b6df4dd93c0de12f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "39d7d42ba54e4d1231f7dab5d1c6900b903f49e362f7a52e1f97ee4916c44d13"
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
