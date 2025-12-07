# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5a312497fa87ac0cf3aa294ef105a5b2374730ce53abfb20239b3eb8e82f1852"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "af857484c301e439fd94de537d6efa3fdba26492acb8d6a26ad8cb34f56a3be7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1f95be57629b6ef427e74958d836255b44d3a8f369c34555c8ca70c3c2f2aeaf"
    sha256 cellar: :any_skip_relocation, sonoma:        "9706d777e00d72de18e8ab00344544426d5d02154daac29369688ec648781db9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cc5c7c289a8323a31044a83f1e2eead1ffa42aebef43209c6f4145351dd58f35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eaaaafebea05df356edbe67dc2d1e13dc727ec94983a347f93b9cdbabb5aa983"
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
