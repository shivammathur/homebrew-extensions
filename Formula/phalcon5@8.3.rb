# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.16.0.tgz"
  sha256 "33db2df75a81224f710a2435f7f81c5fe1486ea1fb11579f66c4875a28b4d607"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e42fc43f369a29cb036180dc8818f7da355386e8f0413174f7c21125b3b0ebcc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9947ad6c44c041418e215cf52e8a9b691543264b970eaf0909e65dc5fcbc32c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d4a46b85f35229dda62035aa99c6c7f0bf67551fe4ffb0e6ca62f4fe175dceaf"
    sha256 cellar: :any_skip_relocation, sonoma:        "fbf75fec83ad478bf5a4308a348879473d5776edee86e54a5dccb13c815ab93b"
    sha256 cellar: :any,                 arm64_linux:   "327dceb1b5b551d276a88598cfb96bbfd3de647c466e231f906ed2c196f662af"
    sha256 cellar: :any,                 x86_64_linux:  "0d39fb0a5668b49f62113fe21417294731eceb4f226eb45b2effea61a4f573ee"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
