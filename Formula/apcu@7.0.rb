# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4382b1638db30286595b223333c4d4c787698c715c4839d2865a5ffe26c4ea47"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e638f1310d951ec07dcef710a9c4a903f5ac69a7188469e296b85631cdc98285"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "992e131618d70eafc0d8366ab39673e49f8f912660c457fd80fd96ed20071b74"
    sha256 cellar: :any_skip_relocation, sonoma:        "ae7bd7b21499f65ec3c02c86b8ae30c94a8bdf7c3fd5520a3994db4a7b97f44d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c87ecbf4bd20fc610541458f501ae4ea948bb806cf83dcb7d7ac7c9892f2711a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "49575b2329351e7df14dc0bacfeb7cac12faf46aa1902fbbe0b3e2595f61e506"
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
