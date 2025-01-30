# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT70 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "6044306d78f2f5be119310dfb64897f315f1adacca27f2fbf6e273bed5a072eb"
    sha256 cellar: :any,                 arm64_sonoma:   "51b2e7b10df1e491456960fc3d9c1ebe94f352aca23873cc551495b277f41974"
    sha256 cellar: :any,                 arm64_ventura:  "4cb37dddbe4b1f3408ced4ee11e237fd627ab21dbc03e1c9e9228eefc64c7910"
    sha256 cellar: :any,                 arm64_monterey: "59b65d81d74983ef332284463607475ade9a3a0d8c4d47cfa38f88a20c9d337e"
    sha256 cellar: :any,                 ventura:        "8b0dbbf4657aae92f3ab6293ff5c4ea68f850dc96182c7d2fe248a12dbbb9896"
    sha256 cellar: :any,                 monterey:       "93850a8e1373c2f8225ab53208f94f7898dcf0a6d21b311f3c8fc5b49e02e46c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5be5447e5aef3970fd654d7997b66c69f4cc8e591562cef373f447856e2af392"
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
