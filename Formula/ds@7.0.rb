# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT70 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.3.0.tgz"
  sha256 "0114b146e1036d75a83cd438200df73db030b5d12b8c687843809d1d0cec91be"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a52047b6e607aa7c41bd6a405e7c412d9eebf0e70fcf1270bba200d6ba896309"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a162bfd7f687021f413d8218c80d1c269daa548d0551b305aae738cbeb8ed91d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "019ca18d6eea6c3eacb6ff863ddf6999e07d83ee7968b341360f28b8e53bb405"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fadea03ec91ee4ef63b278ba7ea7dd2f376fabbb1db962e856a4d9b8bd8950e5"
    sha256 cellar: :any_skip_relocation, ventura:        "0170a415b48488f731d4c808978af03827a6ef6cde91e7586ac288ca4b12b3d3"
    sha256 cellar: :any_skip_relocation, monterey:       "6129f8ca9f0921fa6e586ae5f78219b74285cfbf28c9042b0df2efac7aae982a"
    sha256 cellar: :any_skip_relocation, big_sur:        "16918bfaae5aba8541e93809639a2b7a6768b0624929a6c7edc1a7929ff984d9"
    sha256 cellar: :any_skip_relocation, catalina:       "0dc6757abe52d28adf9677979d48ee7496ceb4c3855a8b7d48ed6139de4521d0"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b6b2e5b3ae5bf220c85bd647c4579bff56f65aae1c9fba32a1d92c8591d97c9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "297d79214838491eaaecf709329e59e5de406ca47ebeca869747e0a7d46c9a4f"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
