# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT85 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0bd18fb732048a53a81571bb48728eb3aaaa6d67fba943cac6609008e656f42e"
    sha256 cellar: :any,                 arm64_sonoma:  "4d1052e423349f1dcd76c406882f0989357e9597a4645e955ef4e28f32ff2d7d"
    sha256 cellar: :any,                 arm64_ventura: "e09f7eda8f086caf0cb2d2f3677e63705b9832f09b01d1271df4416e145c826c"
    sha256 cellar: :any,                 ventura:       "388cf48ff120a26f4e98f7d9596fdb99138ad5f4db8bb0c2a51c139385c607fd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "75b3182ccf12c29dd77e0a0be84dc71213e2e8c2eb1cf83ca69904dcf6a29c79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e69672b61a64e9dea292006a35e9ecb8996fb624974ddd3f35abbf293093166"
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
