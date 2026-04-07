# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "3cf95c36bba67458e533d0d9bdbec0ea429acf3f32bb8f5eedbbc6eb532062af"
    sha256 cellar: :any,                 arm64_sequoia: "64f7ca8afa44e9df70f9e8e0a4422e55352ddd1a941352bade8b72b35da807c8"
    sha256 cellar: :any,                 arm64_sonoma:  "bb58219d4bff0237054bb8b95716df042ff5a642632d1fa98b8a2a87faa2b9a2"
    sha256 cellar: :any,                 sonoma:        "600e13fd14655492bf241bcad99a321c70dc2b26c59654407eec1d6ec27d7aec"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b2c0ba747660628763c00e9c52f038add89c7293a095e5fbe020dff987e89f4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6910bcb30810010939e05531a91a050d1fa222aae8b8f4eae0d6f302bec66693"
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
